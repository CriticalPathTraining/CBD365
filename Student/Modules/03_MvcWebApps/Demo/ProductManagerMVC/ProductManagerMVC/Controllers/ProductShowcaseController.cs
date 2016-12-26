using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProductManagerMVC.Services;

namespace ProductManagerMVC.Controllers
{
    public class ProductShowcaseController : Controller
    {

        private IProductDataService productService = ProductDataConnector.GetProductDataService();

        public ActionResult Index(string categoryFilter) {
            var products = productService.GetAllProducts();

            if (!string.IsNullOrEmpty(categoryFilter)) {
                products = products.Where(p => p.Category.Equals(categoryFilter));
            }

            return View(products);
        }
        
    }
}