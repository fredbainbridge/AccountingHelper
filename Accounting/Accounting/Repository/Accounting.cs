using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.IO;
using Newtonsoft.Json;
using Accounting.Models;
using Microsoft.Extensions.Configuration;

namespace Accounting.Repository
{
    public class Accounting : IAccounting
    {
        private readonly IConfiguration Configuration;
        private AccountingContext _dbContext;
        public Accounting(AccountingContext accountingContext, IConfiguration configuration)
        {
            _dbContext = accountingContext;
            Configuration = configuration;
        }
        public void GatherTransaction()
        {
            string path = Configuration["transactionPath"];
            DirectoryInfo di = new DirectoryInfo(path);
            FileInfo[] files = di.GetFiles("*.json");
            foreach(FileInfo file in files)
            {
                using (StreamReader r = new StreamReader(file.FullName))
                {
                    string json = r.ReadToEnd();
                    List<Transaction> items = JsonConvert.DeserializeObject<List<Transaction>>(json);
                    if (items == null)
                    {
                        continue;
                    }
                    foreach(Transaction t in items)
                    {
                        bool exists = false;
                        if(t.Bank.Equals("Amazon"))
                        {
                           exists = _dbContext.Transactions.Where(b => b.Detail.Equals(t.Detail)).Any();
                        }
                        if(!exists)
                        {
                            exists = _dbContext.Transactions.Where(b =>
                               b.Bank.Equals(t.Bank) &&
                               b.Amount == t.Amount &&
                               b.Date.Year.Equals(t.Date.Year) &&
                               b.Date.Month.Equals(t.Date.Month) &&
                               b.Date.Day.Equals(t.Date.Day) &&
                               b.Description.Equals(t.Description) &&
                               b.Detail.Equals(t.Detail)
                            ).Any();
                        }
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
