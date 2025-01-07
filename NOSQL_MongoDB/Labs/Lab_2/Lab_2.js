use inventory
// 1. Find documents where the "tags" field exists.
db.inventory.find({"tags": {$exists : true}})

// 2.Find documents where the "status" field has a value in [A, B] using both the `$in` , `$or` operators.

db.inventory.find({"status" : {$in : ["A" , "B"]}})

db.inventory.find( {$or : [{"status" : "A"} 
                         , {"status" : "B"}]})
                         
// 3.Find documents where the "tags" field does not contain values "ssl" or "security."
db.inventory.find({"tags" : {$nin : ["ssl" , "security"]}})

// 4.Find documents where the "qty" field is equal to 85.

db.inventory.find({"qty" : 85})

// 5.Find documents where the "qty" field is greater than 95.
db.inventory.find({"qty" : {$gt : 95}})

//6. Find documents where the "qty" field is less than or equal to 45.

db.inventory.find({"qty" : {$lte : 45}})

//7. Find documents where the "tags" array contains all of the values [ssl, security] using the `$all` operator.


db.inventory.find({"tags": {$all : ["ssl" , "security"]}})

//8. Find documents where the "tags" array has a size of 3.


db.inventory.find({"tags": {$size : 3}})


//9.Find documents where the "tags" field is of type array.
db.inventory.find({"tags": {$type : "array"}})

// 10.Update the "item" field in the "paper" document, setting "size.uom" to "meter" and using the `$currentDate` operator.


db.inventory.find({"item" : "paper"})

db.inventory.updateMany({"item" : "paper"} , {$set : {"size.uom" : "meter"}, $currentDate : {"lastUpdated" : true}})

// 10.A ) Also, use the upsert option and change filter condition item:”paper”. 

db.inventory.updateMany({"item" : "paper"} , {set$ : {"size.uom" : "meter"}}, {upsert : true})

// 10.B) Use the `$setOnInsert` operator.

db.inventory.updateMany({"quantity" : 100000} , {$set : {"item" : "HP printer"}, $currentDate : {"lastUpdated" : true},
     $setOnInsert : {"quantity" : 100}} , {upsert : true})

db.inventory.find({"item" : "HP printer"})



// 10.C) Try `updateOne`, `updateMany`, and `replaceOne`. (filter by code)

db.inventory.find({"info.publisher" : "1111"})

db.inventory.updateOne({"info.publisher" : "1111"}, {$set : {"stock" : 5}})

db.inventory.updateMany({"info.publisher" : "1111"}, {$set : {"stock" : 12}})


db.inventory.replaceOne({"info.publisher" : "1111"} , {
  
  "type": "Phone",
  "tags": ["Headphones", "Company", "Technology"],
  "qty": [
    {
      "brand": "Samsung",
      "num": 10,
      "color": "black"
    },
    {
      "brand": "iphone",
      "num": 5,
      "color": "grey"
    }
  ]
}
)

db.inventory.find({"type" : "Phone"})




// 11. Insert a document with incorrect field names "neme" and "ege," then rename them to "name" and "age." 


db.inventory.insertOne({"_id" : 1 , "neme" : "medhat" , "ege" : 23})
db.inventory.find({"_id" : 1})

db.inventory.updateOne({"_id" : 1} , {$rename : {"neme" : "name" , "ege" : "age"}})


// 12. Try to reset any document field using the `$unset` function. 
db.inventory.updateOne({"_id" : 1} , {$unset : {"age" : ""}})

db.inventory.find({"_id" : 1})

// 12. Try update operators like `$inc`, `$min`, `$max`, and `$mul` to modify document fields. 

db.inventory.updateOne({"_id" : 1} , {$set : {"wealth" : 10000000}})

db.inventory.updateOne({"_id" : 1} , {$inc : {"wealth" : 1}}) //increment the current wealth by 1
 
db.inventory.updateOne({"_id" : 1} , {$min : {"wealth" : 1000000}}) //it will change because the new value < the old value

db.inventory.updateOne({"_id" : 1} , {$max : {"wealth" : 5000000}}) // it will change because the new value > the old value

db.inventory.updateOne({"_id" : 1} , {$mul : {"wealth" : 2}}) // multiply the current wealth by 2











