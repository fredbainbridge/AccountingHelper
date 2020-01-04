using System;

namespace Accounting.Models
{
    public class Transaction
    {
        public int Id { get; set; }
        public DateTime Date { get; set; }
        public string Detail { get; set; }
        public string Description { get; set; }
        public string Amount { get; set; }
        public string Bank { get; set; }
    }
}
