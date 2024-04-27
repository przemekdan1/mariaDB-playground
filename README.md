# mariaDB-playground

## Wht is mariaDB?

Unrelational, nosql database which means ACID rule (Atimicy,Consistency,Isolation,Durability) is no ... 

Priority in returnig data, not the structure.  Speed, integrative with programming languages, document oriented

Data are stored in collections field:value in JSON format

## Syntax

### CRUD

Insert

```sql
db.collection.insert()
```

- insertOne()
- insertMany()
```sql
[
    {item: "card",qty:15},
    {item: "stamps".qty:30}
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