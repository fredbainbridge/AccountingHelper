using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace Accounting.Models
{
    public class Transaction
    {
        public int Id { get; set; }
        public DateTime Date { get; set; }
        public string Detail { get; set; }
        public string Description { get; set; }
        public double Amount { get; set; }
        public string Bank { get; set; }
        public int? CategoryID { get; set; }

        [ForeignKey("CategoryID")]
        [InverseProperty("Transactions")]
        public virtual Category Category { get; set; }
    }
}
