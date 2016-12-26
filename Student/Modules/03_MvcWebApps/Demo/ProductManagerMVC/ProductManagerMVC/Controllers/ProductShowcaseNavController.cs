using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProductManagerMVC.Services;

namespace ProductManagerMVC.Controllers {
    public class ProductShowcaseNavController : Controller {

        private IProductDataService productService = ProductDataConnector.GetProductDataService();

        public ActionResult Menu() {

            IEnumerable<string> categories = productService.GetAllProducts()
                .Select(p => p.Category)
                .Distinct()
                .OrderBy(cat => cat);

            return View(categories);
        }
    }
}