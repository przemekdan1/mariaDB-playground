# mongoDB-playground

## What is mongoDB?

MongoDB is a non-relational, NoSQL database, which means it does not strictly adhere to the ACID rule (Atomicity, Consistency, Isolation, Durability) in the same way as traditional relational databases.

Its primary focus is on retrieving data efficiently, prioritizing speed and flexibility over rigid structural constraints. MongoDB is highly integrative with various programming languages and follows a document-oriented approach to data storage.

Data in MongoDB are organized into collections, where each document consists of field-value pairs in JSON format.

## Syntax

### CRUD

Insert

```sql
db.collection.insert()
```

- insertOne()
```sql
db.klienci.insertOne(
    {
      "idKlienta": 100,
      "nazwisko": "Oplski",
      "imie": "Kamil",
      "nrDowodu": "OP9900222",
      "adresZamieszkania": {
        "miejscowosc": "Opole",
        "ulica": "Podkarpacka",
        "nrDomu": 44,
        "nrMieszkania": 678
          }
      }
)

```

- insertMany()
```sql
[
    {
        item: "card",
        qty:15
    },
    {
        item: "stamps",
        qty:30
    }
]
```
- bulkWrite()
```sql
[<operation1>,<operation2>],
{
    writeConcern <document>,
    ordered:<boolean>
}
```
```sql
db.collection.bulkWrite([
    {insertOne: {"document":<document>}}
])
```



Update 

- filtrating results to update
```sql
db.collection.update({"carrer.fee":{$lte:5}},{$set:{price:9.99 }})
```

- updateOne
- updateMany
until all values matching the conditon left
```sql
db.collection.updateMany({violations:{$gt:3}},{$set:{"Review":true}})
```


Remove

- remove - outdated
- deleteOne()
```sql
db.collection.deleteMany({constraints})
```
- deleteMany()
- findOneAndDelete()
- bulkWrite()

### Queries

```sql
db.collecton.find({{query},,{projection}})
```
```sql
db.collection.find({field:{$in:[cond1,cond1]}})
```


id field have special name _id, if not defined it will be generated

### Operators

Aviable operators: eq,nq,gt,gte,lt,lte,nin (not in), in

Inside find method

```sql
{field:{$eq: value}}
```

### Logical operators

Aviable operators: and,or,not,nor, exists

Inside find method

```sql
{$and: [{field:{expression1}},field:{expression2}]}
{$or: [{field:{expression1}},field:{expression2}]}
{$nor: [{field:{expression1}},field:{expression2}]}

{field:{$not: {expression}}}
{field:{$exists:true}}
```

### Modulo, sum
```sql
db.collection.find({field:{$mod:[2,0]}})
```

```sql
db.collection.find({$sum: "fieldName"})
```

### Regex

- Inside / /
- started with ^char,^[set start-end]
- ending with char$
- every one character . 
- every many charactes *

```sql
{field:{$regex: /pattern/,$options:''}}
{field:{$regex: 'pattern',$options:''}}
{field:{$regex: /pattern/''}}
```

options f.ex i - not case sensitive
```sql
{name: {$in:[/^acme/i]}}
```


### $type

searching information about specific datatype

```sql 
.find({"data" : {$type:"array"}})
```


### Array operators

- aviable operators: all,elemMatch, size

- every value in tag is from list
```sql
{tags: {$all["ssl","security"]}}
```
- every constrains about fields from list
```sql
{results:{$elemMatch:{ $gte : 80,$lt : 85}}}
```
- field size, f.ex. is it an array
```sql
{field: {$size : 2}}
```


### Min/max

- query results constraints
```sql
db.collecton.find({<query>}).max({field:<maxValue,field2:<maxValue>>}).min({field:<minValue,field2:<minValue>>}).hint({field1:1,field2:1})
```

```sql
.min({age:20}).max({age:25}).hint({age:1})
``` 


### Projection

```sql
db.bios.find({"name.last": "Hopper"})
db.bios.find({name: {first:"Youhiro",last:"Matsumato"}})
```

When we want to display values from keys
```sql
.find({},{name:1,contribs:1,_id:0})
```


### Date
```sql
{brth: {$gt: new Date('2000-09-28')}}
```
ISODate object - for finding the exact date or in some range, in queries
```sql
db.collection.find({dateField:{$gte: ISODate("2024-01-01"), $lte: ISODate("2024-02-12")}})
```

### Sort/limit/skip

```sql
.find().sort({name:1})
.find().limit(5)
.find().skip(5)
```


### Aggregation

- combining and reporting 
- like in sql: where, group by, order by

```sql
db.orders.aggregate([
    {$match: {status: "A"}},
    {$group: {_id:"$cust_id",total:{$sum: "$amount"}}},
    {$sort: {total:-1}}
]) 
```


### Distinct

- for unrepeatble data
```sql
db.collection.distinct("field_name")
```


### FindAnd...

- findOneAndReplace
replacing existing document with new one, not updating 
```sql
db.scores.findOneAndReplace(
    {"score":{$lt:20000}},
    {"team":"Name","score":20000},
    {sort:{"score":1}}
)
```

- findOneAndUpdate
updating specific records


### Count
counting elements in db or result
```sql
db.collection.count()
```


### Creating collections
```sql
db.createCollection("collection name")
```
```sql
db.collectionName.insertOne()
```