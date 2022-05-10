import UIKit

struct Coffee {
    
    enum CoffeeError: Error {
        case goToRecycleBin
    }
    
    func drink() {
        print("drinking coffee")
    }
    
    func dispose() throws -> Double {
        throw CoffeeError.goToRecycleBin
    }
    
}

//Closure way

func fetchMeCoffee(callback: @escaping (Result<Coffee,Error>)->Void) {
    //some implementation
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        let coffee = Coffee()
        callback(.success(coffee))
    }
}

fetchMeCoffee { result in
    switch result {
    case .failure(let error):
        //todo handler error
        print(error)
    case .success(let coffee):
        //do something with coffee
        coffee.drink()
        
        do {
            let amount = try coffee.dispose()
            
        } catch {
            //todo handler error
            print(error)
        }
    }
}

//Async Await

func getMeCoffee() async throws -> Coffee {
    try await Task.sleep(nanoseconds: 1_000_000_000) //1_000_000_000 is 1 second
    return Coffee()
}

Task {
    do {
        let coffee1 = try await getMeCoffee()
        coffee1.drink()
        
        let coffee2 = try await getMeCoffee()
        coffee2.drink()
        
        try coffee1.dispose()
        try coffee2.dispose()
    } catch {
        //todo handler error
        print(error)
    }
}

