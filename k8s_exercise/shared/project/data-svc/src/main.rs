use libmdbx::{Database, NoWriteMap, WriteFlags};

const DB_NAME: &str = "_db";

fn main() {
    let db = Database::<NoWriteMap>::open(Path::new(DB_NAME)).unwrap();

    // Write
    {
        let mut txn = db.begin_rw_txn().unwrap();
        let table = txn.open_table(None).unwrap();
        for i in 0..100 {
            txn.put(
                &table,
                &format!("key{}", i),
                &format!("data{}", i),
                WriteFlags::empty(),
            )
            .unwrap();
            if i > 50 {
                txn.del(&table, &format!("key{}", i), None).unwrap();
            }
        }
        txn.commit().unwrap();
    }

    // Read
    {
        let mut txn = db.begin_ro_txn().unwrap();
        let table = txn.open_table(None).unwrap();
        for i in 0..100 {
            let value = txn.get::<Vec<u8>>(&table, format!("key{}", i).as_bytes()).unwrap();
            println!("{:?}\n", value);
        }
        txn.commit().unwrap();
    }
}