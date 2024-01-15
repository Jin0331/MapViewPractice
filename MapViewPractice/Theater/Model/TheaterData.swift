
import Foundation

enum SetDefaultCoordinate : Double { // 노들나루공원
    case latitude = 37.5137
    case longitude = 126.9537
}

enum TheaterCase : Int, CaseIterable {
    case all = 0
    case lotte = 1
    case megabox = 2
    case cgv = 3
    
    var index : String {
        switch self {
        case .all :
            return "전체보기"
        case .lotte :
            return "롯데시네마"
        case .megabox :
            return "메가박스"
        case .cgv :
            return "CGV"
        }
    }
}

struct Theater {
    var type : String
    var location : String
    var latitude : Double
    var longitude : Double
}

struct TheaterList {
    var mapAnnotations: [Theater] = [
        Theater(type: "롯데시네마", location: "롯데시네마 서울대입구", latitude: 37.4824761978647, longitude: 126.9521680487202),
        Theater(type: "롯데시네마", location: "롯데시네마 가산디지털", latitude: 37.47947929602294, longitude: 126.88891083192269),
        Theater(type: "메가박스", location: "메가박스 이수", latitude: 37.48581351541419, longitude:  126.98092132899579),
        Theater(type: "메가박스", location: "메가박스 강남", latitude: 37.49948523972615, longitude: 127.02570417165666),
        Theater(type: "CGV", location: "CGV 영등포", latitude: 37.52666023337906, longitude: 126.9258351013706),
        Theater(type: "CGV", location: "CGV 용산 아이파크몰", latitude: 37.53149302830903, longitude: 126.9654030486416)
    ]
}
