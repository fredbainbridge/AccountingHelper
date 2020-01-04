using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Accounting.Models;

namespace Accounting.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AccountingController : ControllerBase
    {
        
        private readonly ILogger<AccountingController> _logger;

        public AccountingController(ILogger<AccountingController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        public void AddTransaction(Transaction transaction)
        {

        }
    }
}
