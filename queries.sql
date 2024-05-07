db.klienci.find()

db.klienci.find({nazwisko: "Kowalski"})

db.klienci.find({"adresZamieszkania.nrDomu": {$gt:30,$lt:70}})

db.klienci.find({eMail:/^N/})

db.klienci.find({nazwisko: $in[{/^adam/i}]})????

db.klienci.find({eMail: /com$/})

db.pokoje.find({dostawka:/T/})

db.zakwaterowanie.find({},{_id:0,idZakwaterowania:1,dataZakwaterowania:1,dataWykwaterowania:1})

db.pokoje.find({pietro:2,liczbaMiejsc:1,dostawka:/T/})

db.klienci.find({imie:{$in:["Adam","Marta","Beata"]}})

db.klienci.find({imie:{$nin:["Adam","Marta","Beata"]}}).sort({nazwisko})

db.klienci.find({},{nazwisko:1,imie:1,idKlienta:1}).sort({nazwisko:1,imie:-1})

db.zakwaterowanie.find({koszt:{$exists:true}}).sort({koszt:1})

db.pokoje.find({dostawka:/T/,"cenaZaDostawke.0.cenaZaDobe":{$gt:50}})

db.pokoje.find({dostawka:/T/,cenaZaDobe:{$gt:300}},{_id:0,idPokoju:1}).sort({cenaZaDobe:1})

db.klienci.find({$and:[{"adresZamieszkania.miejscowosc":/Warszawa/},{"adresZamieszkania.ulica":/Polna/}]})



db.klienci.find({eMail:/^..[ap].*/})

db.klienci.find({eMail:/o2/},{_id:0,nrDowodu:1})

db.pokoje.find({dostawka:/T/,"cenaZaDostawke.0.liczbaDostawek":1,"cenaZaDostawke.0.cenaZaDobe":{$gt:50,$lt:80}})

db.pokoje.find({pietro:2}).limit(3)

db.pokoje.find({pietro:2}).limit(3).skip(2)

db.pokoje.find({cenaZaDobe:{$lte:200}},{_id:0,idPokoju:1,liczbaMiejsc:1,cenaZaDobe:1})

db.klienci.find({idKlienta:{$gte: ISODate("2024-01-01"), $lte: ISODate("2024-02-12")}})

db.pokoje.find({"cenaZaDostawke.1.cenaZaDobe":100}) 

db.pokoje.find({"cenaZaDostawke.0.cenaZaDobe": {$gte:20,$lte:80}})

db.pokoje.find({"cenaZaDostawke": {$type:"array"}}

db.pokoje.find({liczbaMiejsc:{$mod:[2,0]}})

db.pokoje.find().min({cenaZaDobe:400}).max({cenaZaDobe:1000}).hint({cenaZaDobe:1})



db.klienci.find({imie: {$in:[/Adam/i,/Tomasz/i]}}).count()

db.zakwaterowanie.aggregate(
    {$group:{_id:"$idKlienta",total:{$sum:"$koszt"}}},
    {$sort:{_id:1}}
)

db.klienci.aggregate([
    {$match: {imie: {$in:[/Adam/i,/Marta/i,/Beata/i]}}},
    {$group: {_id:"$idKlienta",count:{$sum:1}}},
    {$sort:{count:1}}
])

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

db.klienci.insertMany([
  {
    "idKlienta": 200,
    "nazwisko": "Kaminski",
    "imie": "Teodor",
    "nrDowodu": "KT124546",
    "adresZamieszkania": {
      "miejscowosc": "Gdynia",
      "ulica": "Katowicka",
      "nrDomu": 89
    }
  },
  {
    "idKlienta": 201,
    "nazwisko": "Tokarczuk",
    "imie": "Eleonora",
    "nrDowodu": "TE4434352"
  }
])

db.klienci.updateOne({idKlienta:100},{$set:{"eMail":"opolK234@o3.pl"}})

db.pokoje.updateMany({dostawka:"T",cenaZaDobe:{$gte:99,$lt:210}},{$set:{cenaZaDobe:2000}})

db.klienci.findOneAndUpdate({eMail:/.com$/,komercyjny:{$exists:false}},{$set:{komercyjny:1}})

db.klienci.findOneAndReplace({eMail:/.com$/,komercyjny:{$exists:false}},{komercyjny:1})

db.klienci.deleteMany({eMail:{$exists:false}})

db.kolekcja.insertOne({
    "poleTekstowe": "tekst",
    "liczby": [1,2,3],
    "data": new Date("2024-05-07")
})

db.kolekcja.insertMany(
{
    "poleTekstowe": "tekst",
    "liczby": [1,2,3],
    "data": new Date("2024-05-07")
},
{
    "poleTekstowe": "dasdas",
    "liczby": [312,2,3],
    "data": new Date("2024-05-06")
},
{
    "poleTekstowe": "dsa",
    "liczby": [0,0,0],
    "data": new Date("2024-05-01")
})

db.kolekcja.updateMany({poleTekstowe:"dsa"},{$set:{"poleTekstowe":"fuuu"}})

db.kolekcja.drop()