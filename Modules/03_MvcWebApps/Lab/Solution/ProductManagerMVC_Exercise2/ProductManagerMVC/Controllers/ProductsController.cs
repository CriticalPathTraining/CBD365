using System.Net;
using System.Web;
using System.Web.Mvc;
using ProductManagerMVC.Models;
using ProductManagerMVC.Services;


namespace ProductManagerMVC.Controllers {
  public class ProductsController : Controller {

    private IProductDataService productService = new InMemoryProductDataService();

    public ActionResult Index() {
      return View(productService.GetAllProducts());
    }

    public ActionResult Details(int? id) {
      if (id == null) {
        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
      }
      Product product = productService.GetProduct(id.Value);
      if (product == null) {
        return HttpNotFound();
      }
      return View(product);
    }

    public ActionResult Create() {
      return View();
    }

    [HttpPost, ValidateAntiForgeryToken]
    public ActionResult Create([Bind(Include = "Id,Name,Category,ListPrice,Description,ProductImageUrl")]
                                Product product) {
      if (ModelState.IsValid) {
        productService.AddProduct(product);
        return RedirectToAction("Index");
      }

      return View(product);
    }

    public ActionResult Edit(int? id) {
      if (id == null) {
        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
      }
      Product product = productService.GetProduct(id.Value);
      if (product == null) {
        return HttpNotFound();
      }
      return View(product);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public ActionResult Edit([Bind(Include = "Id,Name,Category,ListPrice,Description,ProductImageUrl")] Product product) {
      if (ModelState.IsValid) {
        productService.UpdateProduct(product);
        return RedirectToAction("Index");
      }
      return View(product);
    }

    public ActionResult Delete(int? id) {
      if (id == null) {
        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
      }
      Product product = productService.GetProduct(id.Value);
      if (product == null) {
        return HttpNotFound();
      }
      return View(product);
    }

    [HttpPost, ActionName("Delete")]
    [ValidateAntiForgeryToken]
    public ActionResult DeleteConfirmed(int id) {
      productService.DeleteProduct(id);
      return RedirectToAction("Index");
    }

  }
}