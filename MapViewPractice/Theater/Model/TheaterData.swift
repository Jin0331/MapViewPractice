
import Foundation

enum SetDefaultCoordinate : Double { // 청년취업사관학교 창동캠퍼스
    case latitude = 37.65455
    case longitude = 127.0502
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
        Theater(type: "롯데시네마", location: "롯데시네마 수락산", latitude: 37.67847, longitude: 127.0559),
        Theater(type: "롯데시네마", location: "롯데시네마 노원", latitude: 37.6548365, longitude: 126.88891083192269),
        Theater(type: "메가박스", location: "메가박스 창동", latitude: 37.6545747, longitude:  127.061187),
        Theater(type: "CGV", location: "CGV 방학", latitude: 37.6673, longitude: 127.0445),
        Theater(type: "CGV", location: "CGV 수유", latitude: 37.642338, longitude: 127.0300198)
    ]
}
