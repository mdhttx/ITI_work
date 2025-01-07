 db.createCollection("Staff")
 
 db.Staff.insertOne({_id : 1, name : "Ali" , age : 37 , gender : "male" , department : "Finance"})

db.Staff.insertMany([
{_id : 2 , name : "Luis" , age: 20, gender: "male", department : "Management"}
,
{_id : 3, name : "Christina", age: 25, gender: "female", managerName : "Shawn" , department : "IT"}
,
{_id : 4, name : "Malcom", age: 15, gender : "male", DOB : "27/1/2009"}
])


//find all documents in the staff collection
db.Staff.find()

// Find documents where gender is "male".
db.Staff.find({gender : "male"})

//Find documents with age between 20 and 25.
db.Staff.find({age : {$gte : 20 , $lte : 25}})

//Find documents where age is 25 and gender is "female".
db.Staff.find({gender : "female" , age : 25 })

//Find documents where age is 20 or gender is "female".
db.Staff.find({$or : [{age : 20} , {gender : 'female'}]})

// 5.Update one document in the "Staff" collection where age is 15, set the name to "new student".
db.Staff.updateMany({age : 15} , {$set : {name : "Emad"}})

// 6. Update many documents in the "Staff" collection, setting the department to "AI".

db.Staff.updateMany({} , {$set : {department : "AI"}})

// 7.Create a new collection called "test" and insert documents from Question 3.
db.createCollection("test")
db.test.insertMany([
{_id : 2 , name : "Luis" , age: 20, gender: "male", department : "Management"}
,
{_id : 3, name : "Christina", age: 25, gender: "female", managerName : "Shawn" , department : "IT"}
,
{_id : 4, name : "Malcom", age: 15, gender : "male", DOB : "27/1/2009"}
])

db.test.find()

// 8.Try to delete one document from the "test" collection where age is 15.
db.test.deleteOne({age : 15})

// 9.try to delete all male gender
db.test.deleteMany({gender : "male"})

// 10.Try to delete all documents in the "test" collection.
db.test.deleteMany({})



