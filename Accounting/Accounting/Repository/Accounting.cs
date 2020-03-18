using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.IO;
using Newtonsoft.Json;
using Accounting.Models;

namespace Accounting.Repository
{
    public class Accounting : IAccounting
    {
        private AccountingContext _dbContext;
        public Accounting(AccountingContext accountingContext)
        {
            _dbContext = accountingContext;
        }
        public void GatherTransaction()
        {
            string path = @"D:\apps\accounting";
            DirectoryInfo di = new DirectoryInfo(path);
            FileInfo[] files = di.GetFiles("*.json");
            foreach(FileInfo file in files)
            {
                using (StreamReader r = new StreamReader(file.FullName))
                {
                    string json = r.ReadToEnd();
                    List<Transaction> items = JsonConvert.DeserializeObject<List<Transaction>>(json);
                    foreach(Transaction t in items)
                    {
                        //does it already exist?
                        bool exists = _dbContext.Transactions.Where(b =>
                           b.Bank.Equals(t.Bank) &&
                           b.Amount == t.Amount &&
                           b.Date.Equals(t.Date) &&
                           b.Description.Equals(t.Description) &&
                           b.Detail.Equals(t.Detail)
                        ).Any();
                        if(!exists)
                        {
                            _dbContext.Transactions.Add(t);
                            _dbContext.SaveChanges();
                        }
                    }
                    
                }
            }
        }
    }
}
