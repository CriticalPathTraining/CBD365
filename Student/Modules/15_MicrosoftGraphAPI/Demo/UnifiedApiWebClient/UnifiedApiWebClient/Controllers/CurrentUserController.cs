using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using UnifiedApiWebClient.Models;

namespace UnifiedApiWebClient.Controllers {

  [Authorize]
  public class CurrentUserController : Controller {

    public async Task<ActionResult> Index() {
      OfficeUser user = await UnifiedApiManager.GetCurrentUser();
      return View(user);
    }

    public async Task<ActionResult> Inbox() {
      OfficeMessageCollection messages = await UnifiedApiManager.GetInbox();
      return View(messages.value);
    }

  }
}