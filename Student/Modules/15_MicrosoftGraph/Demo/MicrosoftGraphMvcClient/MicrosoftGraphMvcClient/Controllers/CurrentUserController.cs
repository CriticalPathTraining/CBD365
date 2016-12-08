using MicrosoftGraphMvcClient.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace MicrosoftGraphMvcClient.Controllers
{
    [Authorize]
    public class CurrentUserController : Controller {

        public async Task<ActionResult> Index() {
            Office365User user = await MicrosoftGraphApiManager.GetCurrentUser();
            return View(user);
        }

        //public async Task<ActionResult> Inbox() {
        //    //OfficeMessageCollection messages = await UnifiedApiManager.GetInbox();
        //    //return View(messages.value);
        //    return View();
        //}
    }
}