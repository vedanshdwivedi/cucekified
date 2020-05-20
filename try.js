document.getElementById('studentRegistrationForm').addEventListener('submit', formSubmit);
function formSubmit(e) {
    document.getElementById('submit').style.display = 'none';
    e.preventDefault();
    let name = document.querySelector('#name').value;
    let regNo = document.querySelector('#regNo').value;
    let email = document.querySelector('#email').value;
    let roll = document.querySelector('#roll').value;
    let password = document.querySelector('#regNo').value;
    let finalyear = document.querySelector('#year').value;
    year = parseInt(finalyear, 10);
    let branch = document.querySelector('#branch').value;
    var role = "S";
    var workHour = 0;
    var totalHour = 0;
    sendMessage(name, regNo, email, roll, password, year, branch);
    document.getElementById('studentRegistrationForm').reset();
    document.getElementById('submit').style.display = 'block';
}
var firestore = firebase.firestore();
const db = firestore.collection("students");
const att = firestore.collection("attendance");
function sendMessage(name, regNo, email, roll, password, year, branch) {
    db.doc().set({
        dept: branch,
        gmail: email,
        password: password,
        regNo: regNo,
        role: "S",
        roll: roll,
        totalHour: 0,
        username: name,
        workingHour: 0,
        year: year
    }).then(function () {
        console.log("Data Saved");
        alert('Data Saved Sucessfully');
    }).catch(function (error) {
        console.log(error);
    });
    att.doc(regNo).set({}).then(function () {
        console.log('Attendance Initialised');
        alert('Attendance data initialised, use reg no as your password to login');
    }).catch(function (error) {
        console.log(error);
    });
}