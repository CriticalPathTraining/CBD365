using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using UnifiedApiWebClient.Models;

namespace UnifiedApiWebClient.Controllers {

  [Authorize]
  public class CurrentTenantController : Controller {

    public async Task<ActionResult> Index() {
      OfficeTenant tenant = await UnifiedApiManager.GetTenantDetails();
      return View(tenant);
    }

    public async Task<ActionResult> Users() {
      List<OfficeUser> users = await UnifiedApiManager.GetUsers();
      return View(users);
    }

    public async Task<ActionResult> DisplayUser(string id) {
      OfficeUser user = await UnifiedApiManager.GetUser(id);
      return View(user);
    }
  }
}