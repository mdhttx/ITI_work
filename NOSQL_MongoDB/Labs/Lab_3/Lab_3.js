//2) Provide the MongoDB code for enforcing JSON schema validation when creating a collection named "employees" with required fields "name,
//" "age" (min. 18), and "department" (limited to ["HR," "Engineering," "Finance"]).mi 

db.createCollection("employees", {validator : {$jsonSchema : {bsonType : "object" , required : ["name","age","department"],
properties : {name : {bsonType : "string" , description : "Name must be integer"},
              age : {bsonType : "int" , minimum : 18, description : "Age must be integer and of a value greater than 18"},
              department : {bsonType : "string", enum : ["HR","Engineering","Finance"]}}}}})

//3) Calculate the total revenue for sales collection documents within the date range '01-01-2020' to '01-01-2023' and then sort them in descending order by total revenue. 
use ITI_Mongo
db.sales.aggregate([{$match : {date : {$gte : ISODate("2020-01-01"), $lte : ISODate("2023-01-01")}}},
                     {$group : {_id : "$product" , totalRevenue : {$sum : {$multiply: ["$quantity","$price"]}}} },
                     { $sort : {totalRevenue : -1}}])

db.sales.find()

//4) Calculate the average salary for employees for each department from the employee’s collection. 

db.employees.aggregate([{$group : {_id : "$department", avgSalary : {$avg : "$salary"}}}]) 


// 5) Use likes Collection to calculate max and min likes per title 

db.likes.aggregate([{$group : {_id : "$title" , maxLikes : {$max : "$likes"} , minLikes : {$min : "$likes"}}}])

//6) Get inventory collection Count 

db.inventory.find()
db.inventory.countDocuments() 


// 7) Display 5 documents only from inventory collection 



db.inventory.find().limit(5)

// 8) Count numbers of large Pizza size from orders collection  [using $count inside aggregate function] 


db.orders.find()
db.orders.aggregate([{$match : {size : "large"}} , {$count : "LargePizzaCount"}])



