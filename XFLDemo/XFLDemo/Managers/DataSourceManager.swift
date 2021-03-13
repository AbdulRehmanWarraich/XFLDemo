//
//  DataSourceManager.swift
//  XFLDemo
//
//  Created by AbdulRehman on 07/03/2021.
//

import Firebase
import ObjectMapper

enum FirebaseEntities: String {
    case matches = "Matches"
    case teams = "Teams"
}

class DataSourceManager {
    
    // MARK:- Shared Instance
    static let shared = DataSourceManager()
    var databaseRef: DatabaseReference?
    var authRef: Auth?
    
    private init() {
    }
    
    /**
     Will configure Firebase App and initialize Firebase Database and Auth objects
     */
    func configure() {
        FirebaseApp.configure()
        databaseRef = Database.database().reference()
        authRef = Auth.auth()
    }
    
    //MARK: - Auth
    var isLoggedIn: Bool {
        if authRef?.currentUser != nil{
            return true
        }
        return false
    }
    /**
     Call to login with Firebase Auth
     - Parameters:
     - email: user email
     - password: user password
     - completion: Will retrun Result<Bool, Error> base on Firebase response
     - Returns: void
     */
    func login(email:String, password: String, completion: @escaping (_ result: Result<Bool, Error>) -> ()) {
        
        authRef?.signIn(withEmail: email, password: password) { (authResult, error) in
            if let errorObject = error {
                completion(.failure(errorObject))
            } else {
                completion(.success(true))
            }
        }
    }
    /**
     Call to signOut from Firebase Auth
     - Parameter completion: Will retrun Result<Bool, Error> base on Firebase response
     - Returns: void
     */
    func signOut(completion: @escaping (_ result: Result<Bool, Error>) -> ()) {
        
        do {
            try authRef?.signOut()
            databaseRef?.removeAllObservers()
            
            completion(.success(true))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    //MARK: - Database Fetch
    /**
     Will fetch all matchs schedules and map in objects and will add observer to be called late if data is updated
     - Parameter completion: Will retrun Array of all matchs present in Firebase Database
     - Returns: void
     */
    func fetchsMatchesSchedules(completion: @escaping (_ matches: [Match]) -> ()) {
        databaseRef?.child(FirebaseEntities.matches.rawValue).observe(.value) { (snapshot) in
            
            var data: [Match] = []
            
            snapshot.children.forEach { (aObject) in
                
                if let dataObject = aObject as? DataSnapshot,
                   var matchData = Mapper<Match>().map(JSONObject: dataObject.value) {
                    
                    matchData.key = dataObject.key
                    matchData.aTeam?.key = matchData.aTeamKey
                    matchData.bTeam?.key = matchData.bTeamKey
                    data.append(matchData)
                }
            }
            
            completion(data)
        }
    }
    /**
     Will fetch all teams and map in objects and also, will add observer to be called late if data is updated
     - Parameter completion: Will retrun Array of all Teams present in Firebase Database
     - Returns: void
     */
    func fetchsTeams(completion: @escaping (_ matches: [Team]) -> ()) {
        
        databaseRef?.child(FirebaseEntities.teams.rawValue).observe(.value) { [weak self] (snapshot) in
            self?.processFetchedTeamsData(snapshot: snapshot, completion: completion)
        }
    }
    
    /**
     Will fetch all teams and map in objects only once and will not obsever for changes
     - Parameter completion: Will retrun Array of all Teams present in Firebase Database
     - Returns: void
     */
    func fetchsTeamsOnce(completion: @escaping (_ matches: [Team]) -> ()) {
        
        databaseRef?.child(FirebaseEntities.teams.rawValue).observeSingleEvent(of: .value) { [weak self] (snapshot) in
            self?.processFetchedTeamsData(snapshot: snapshot, completion: completion)
        }
    }
    
    private func processFetchedTeamsData(snapshot: DataSnapshot, completion: @escaping (_ matches: [Team]) -> ()) {
        
        var data: [Team] = []
        
        snapshot.children.forEach { (aObject) in
            
            if let dataObject = aObject as? DataSnapshot,
               var teamData = Mapper<Team>().map(JSONObject: dataObject.value) {
                
                teamData.key = dataObject.key
                data.append(teamData)
            }
        }
        
        completion(data)
    }
    //MARK: - Database Update
    /**
     Will store new match schedule in Firebase Database.
     - Parameters:
     - dateStamp: date and time details
     - aTeam: first team
     - bTeam: second team
     - completion: Will retrun `Result<Bool, Error> `base on Firebase response
     - Returns: void
     */
    func scheduleMatch(dateStamp: String, aTeam: Team, bTeam: Team, completion: @escaping (_ result: Result<Bool, Error>) -> ()) {
        let body = ["datestamp": dateStamp,
                    "aTeamKey": aTeam.key,
                    "aTeam": aTeam.toJSON(),
                    "bTeamKey": bTeam.key,
                    "bTeam": bTeam.toJSON()] as [String : Any]
        
        databaseRef?.child(FirebaseEntities.matches.rawValue).childByAutoId().updateChildValues(body) { (authResult, error) in
            
            if let errorObject = error as? NSError {
                completion(.failure(errorObject))
            } else {
                completion(.success(true))
            }
        }
    }
    
    /**
     Will store update match schedule in Firebase Database.
     - Parameters:
     - match: match object which is played
     - completion: Will retrun `Result<Bool, Error> `base on Firebase response
     - Returns: void
     */
    func updateMatch(match: Match, completion: @escaping (_ result: Result<Bool, Error>) -> ()) {
        var matchBody = match
        matchBody.isPlayed = true
        
        databaseRef?.child("\(FirebaseEntities.matches.rawValue)/\(matchBody.key)").updateChildValues(matchBody.toJSON()) { (authResult, error) in
            
            if let errorObject = error as? NSError {
                completion(.failure(errorObject))
            } else {
                completion(.success(true))
            }
        }
    }
    
    /**
     Will store match results
     - Parameters:
     - winnerTeam: Object of a team which won
     - losserTeam:  Object of a team which loss
     - isDraw:  send `true` if both team scored equal goals. By default it's `false`
     - completion: Will retrun `Result<Bool, Error>` base on Firebase response
     - Returns: void
     */
    func storeMatchResult(winnerTeam: Team, losserTeam: Team, isDraw: Bool = false, completion: @escaping (_ result: Result<Bool, Error>) -> ()) {
        
        fetchsTeamsOnce { (teams) in
            
            var wTeaam: Team?
            var lTeaam: Team?
            
            teams.forEach { (aObject) in
                if aObject.key == winnerTeam.key{
                    
                    wTeaam = aObject
                    
                } else if aObject.key == losserTeam.key {
                    
                    lTeaam = aObject
                }
            }
            
            guard var wTeamObject = wTeaam,
                  var lTeamObject = lTeaam else {
                return completion(.failure(NSError.create(reason: "Team data loading failed", description: "Unexpected error occurred during match result storage")))
            }
            if(isDraw) {
                wTeamObject.draw += 1
                lTeamObject.draw += 1
            } else {
                wTeamObject.won += 1
                lTeamObject.loss += 1
            }
            
            self.databaseRef?.child(FirebaseEntities.teams.rawValue).updateChildValues([winnerTeam.key : wTeamObject.toJSON(),
                                                                                        losserTeam.key : lTeamObject.toJSON()]){ (error, ref) in
                
                if let errorObject = error {
                    completion(.failure(errorObject))
                } else {
                    completion(.success(true))
                }
            }
        }
    }
}
