using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations.Schema;

namespace Accounting.Models
{
    public class Category
    {
        public int Id { get; set; }
        public string Name { get; set; }
        [InverseProperty("Category")]
        public virtual ICollection<Transaction> Transactions { get; set; }
    }
}
