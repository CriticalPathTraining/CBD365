using System.Linq;
using System.Web.Mvc;
using System.Threading.Tasks;
using ProductManagerMVC.Models;
using ProductManagerMVC.Services;
using System.Collections.Generic;

namespace ProductManagerMVC.Controllers {

  public class ProductShowcaseController : Controller {

    private IProductDataServiceAsync productService = ProductDataServiceConnector.GetAsyncProductDataService();

    public async Task<ActionResult> Index(string categoryFilter) {
      var products = await productService.GetAllProductsAsync();
      // get unique list of product categories
      IEnumerable<string> categories = products
                                          .Select(p => p.Category)
                                          .Distinct()
                                          .OrderBy(cat => cat);

      if (!string.IsNullOrEmpty(categoryFilter)) {
        products = products.Where(p => p.Category.Equals(categoryFilter));
      }

      ProductShowcaseViewModel model = new ProductShowcaseViewModel {
        Products = products,
        Categories = categories
      };

      return View(model);
    }
  }
}