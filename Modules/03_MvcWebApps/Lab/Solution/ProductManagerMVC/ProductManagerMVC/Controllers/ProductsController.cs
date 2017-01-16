using System.Net;
using System.Web;
using System.Web.Mvc;
using ProductManagerMVC.Models;
using ProductManagerMVC.Services;
using System.Threading.Tasks;

namespace ProductManagerMVC.Controllers {
  public class ProductsController : Controller {

    private IProductDataServiceAsync productService = ProductDataServiceConnector.GetAsyncProductDataService();

    public async Task<ActionResult> Index() {
      return View(await productService.GetAllProductsAsync());
    }

    public async Task<ActionResult> Details(int? id) {
      if (id == null) {
        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
      }
      Product product = await productService.GetProductAsync(id.Value);
      if (product == null) {
        return HttpNotFound();
      }
      return View(product);
    }

    public ActionResult Create() {
      return View();
    }

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<ActionResult> Create([Bind(Include = "Id,Name,Category,ListPrice,Description,ProductImageUrl")] Product product) {
      if (ModelState.IsValid) {
        await productService.AddProductAsync(product);
        return RedirectToAction("Index");
      }

      return View(product);
    }

    public async Task<ActionResult> Edit(int? id) {
      if (id == null) {
        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
      }
      Product product = await productService.GetProductAsync(id.Value);
      if (product == null) {
        return HttpNotFound();
      }
      return View(product);
    }

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<ActionResult> Edit([Bind(Include = "Id,Name,Category,ListPrice,Description,ProductImageUrl")] Product product) {
      if (ModelState.IsValid) {
        await productService.UpdateProductAsync(product);
        return RedirectToAction("Index");
      }
      return View(product);
    }

    public async Task<ActionResult> Delete(int? id) {
      if (id == null) {
        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
      }
      Product product = await productService.GetProductAsync(id.Value);
      if (product == null) {
        return HttpNotFound();
      }
      return View(product);
    }

    [HttpPost, ActionName("Delete"), ValidateAntiForgeryToken]
    public async Task<ActionResult> DeleteConfirmed(int id) {
      await productService.DeleteProductAsync(id);
      return RedirectToAction("Index");
    }

  }
}