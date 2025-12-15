import cors from "cors";
import express, { request } from 'express';
import mysql from 'mysql'
const app = express();

app.listen(3000, ()=>{
    console.log("connected to the backend")
});

app.use(cors());
app.use(express.json());
const db = mysql.createConnection({
 host : "localhost", 
 user : "root",
 password : "",
 database: "flutter",

});

app.get("/getstudents", (req, res)=>{
    const q = "select * from Student";
    db.query(q,(err,data)=> {
        if(err){
            console.log(err);
            return res.status(500).json(err);
        }
        return res.status(200).json(data);
    })
})

app.post("/addstudent", (req, res) => {
  const q = "insert into Student (`Name`, `Grade`) values (?,?)";
  const { Name, Grade } = req.body;
  db.query(q, [Name, Grade], (err, data) => {
    if (err) {
      if (err.errno === 1062) {
        return res.status(409).json("Duplicate entry");
      }
      console.log(err);
      return res.status(500).json(err);
    } else {
      return res.json(data);
    }
  });
});

app.delete("/deletestudent/:id", (req, res) => {
  const q = "DELETE FROM Student WHERE id = ?";
  const { id } = req.params;
  db.query(q, [id], (err, data) => {
    if (err) {
      console.log(err);
      return res.status(500).json(err);
    }
    if (data.affectedRows === 0) {
      return res.status(404).json("Student not found");
    }
    return res.status(200).json("Student deleted successfully");
  });
});