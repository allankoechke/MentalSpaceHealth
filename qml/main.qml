import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.LocalStorage 2.12

import "./views"
import "./controls"

Window {
    id: mainApp
    width: 640
    height: 480
    visible: true
    title: qsTr("Mental Space Health")


    property alias fontAwesomeFontLoader: fontAwesomeFontLoader
    property int stackCurrentIndex: 0
    property alias userDetailsPopup: infoPopup
    property alias patientPopup: patientPopup
    property real b_: 70
    property real c_: 3

    function getDb()
    {
        return LocalStorage.openDatabaseSync("MentalSpaceHealthDB", "1.0", "Mental Space Health DB", 1000000);
    }

    function initDb()
    {
        var db = getDb();

        db.transaction(
                    function(tx) {
                        // Create the database if it doesn't already exist
                        tx.executeSql('CREATE TABLE IF NOT EXISTS Patient(id INTEGER PRIMARY KEY AUTOINCREMENT, p_name TEXT, p_id TEXT, d_id TEXT, p_contact TEXT, t_name TEXT, t_contact TEXT, date_added TEXT, last_bpm INT, last_edh REAL, starred BOOL)');
                        tx.executeSql('CREATE TABLE IF NOT EXISTS Data(id INTEGER PRIMARY KEY AUTOINCREMENT, d_id TEXT, data TEXT, date TEXT)');
                    }
                    )

        // Load Data in Db
        dbReadAll();
    }

    function switchScreen(){
        if(stackCurrentIndex == 0)
            stackview.replace("qrc:/qml/views/SplashScreen.qml")
        if(stackCurrentIndex == 1)
            stackview.replace("qrc:/qml/views/HomeScreen.qml")
        else
            stackview.replace("qrc:/qml/views/SplashScreen.qml")
    }

    onStackCurrentIndexChanged: switchScreen()
    Component.onCompleted: {switchScreen(); mainApp.showMaximized(); initDb(); }

    StackView
    {
        id: stackview
        initialItem: Item{}
        anchors.fill: parent
    }

    FontLoader
    {
        id: fontAwesomeFontLoader
        source: "qrc:/assets/fonts/fontawesome.otf"
    }

    InfoPopup
    {
        id: infoPopup

        function start(name, pid,did,cif,tnm,tno)
        {
            infoPopup.open()

            // Set Values
            userNames=name
            patientId=pid
            deviceId=did
            contactInfo=cif
            therapistName=tnm
            therapistNo=tno

            // console.log("Data: ",name, pid,did,cif,tnm,tno)
        }
    }

    AddPatientPopup
    {
        id: patientPopup
    }

    ListModel
    {
        id: usersModel

        ListElement
        {
            name: "Mark Holmes"
            userId: "462876481"
            deviceID: "HGSHG879867"
            contact: "254711223333"
            therapistName: "Dr. Andreas Holmes"
            therapistNum: "2677234235"
            dateAdded: "2020-11-11T12:34:00.000"
            lastBpm: 70
            lastEdh: 4
            isStarred: false
        }

        ListElement
        {
            name: "June Holmes"
            userId: "4ASJ6481"
            deviceID: "76287379867"
            contact: "254777338333"
            therapistName: "Prof. John Mark"
            therapistNum: "2547234235"
            dateAdded: "2020-12-21T12:34:00.000"
            lastBpm: 72
            lastEdh: 2.5
            isStarred: true

        }
    }

    // JS CODE +++++++++++++++++++++++++++++++++++
    function addPatient(userNames,patientId,deviceId,contactInfo,therapistName,therapistNo)
    {
        var db = getDb();

        try {
            db.transaction(function (tx) {
                tx.executeSql('INSERT INTO Patient(p_name,p_id,d_id,p_contact,t_name,t_contact,date_added,last_bpm,last_edh,starred) VALUES(?,?,?,?,?,?,?,?,?,?)',
                              [userNames,patientId,deviceId,contactInfo,therapistName,therapistNo, Qt.formatDateTime(new Date(), "yyyy-dd-MMThh:mm:ss.zzz"), 0, 0, false])

                console.log("Added!")
            })

            dbReadAll();
            return true;

        } catch (err) {
            console.log("Error creating table in database: " + err)
            return false;
        };

        console.log("Failed!")
        return false;
    }

    function dbReadAll()
    {
        usersModel.clear();

        var db =  getDb();
        db.transaction(function (tx) {
            var results = tx.executeSql(
                        'SELECT p_name,p_id,d_id,p_contact,t_name,t_contact,date_added,last_bpm,last_edh,starred FROM Patient')

            for (var i = 0; i < results.rows.length; i++) {
                usersModel.append({
                                      name: results.rows.item(i).p_name,
                                      userId: results.rows.item(i).p_id,
                                      deviceID: results.rows.item(i).d_id,
                                      contact: results.rows.item(i).p_contact,
                                      therapistName: results.rows.item(i).t_name,
                                      therapistNum: results.rows.item(i).t_contact,
                                      dateAdded: results.rows.item(i).date_added,
                                      lastBpm: results.rows.item(i).last_bpm,
                                      lastEdh: results.rows.item(i).last_edh,
                                      isStarred: results.rows.item(i).starred===0? false:true,
                                  })
            }
        })
    }

    function dbUpdateRow(Prowid, state)
    {
        var db = dbGetHandle()

        try {
            db.transaction(function (tx) {
                tx.executeSql('UPDATE Patient SET starred=? WHERE p_id = ?', [Prowid, state])
            })

            dbReadAll();
            return true;

        } catch (err) {
            console.log("Error creating table in database: " + err)
            return false;
        };

        return false;
    }

    // JS CODE +++++++++++++++++++++++++++++++++++
}
