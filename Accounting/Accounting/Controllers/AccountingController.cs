using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Accounting.Models;
using Accounting.Repository;

namespace Accounting.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AccountingController : ControllerBase
    {
        
        private readonly ILogger<AccountingController> _logger;
        private IAccounting _accounting;

        public AccountingController(ILogger<AccountingController> logger, IAccounting accounting)
        {
            _logger = logger;
            _accounting = accounting;
        }

        [HttpGet]
        public void Gather()
        {
            _accounting.GatherTransaction();
        }
    }
}
