import Foundation

let currentDate = Date()
let dateFormatter = DateFormatter()

dateFormatter.locale = Locale.current

var existingAlarms = [1, 2, 4, 5, 6, 7]

var IDAvailable: Bool = false
var alarmID = 1
while IDAvailable == false {
    for alarm in existingAlarms {
        if alarm == alarmID {
            IDAvailable = false
            alarmID += 1
            break
        } else {
            IDAvailable = true
        }
    }
}

let newAlarmID = alarmID
