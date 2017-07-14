using System.Web.Mvc;

namespace ProductManagerMVC.Controllers {
  public class HomeController : Controller {
    public ActionResult Index() {
      return View();
    }
  }
}