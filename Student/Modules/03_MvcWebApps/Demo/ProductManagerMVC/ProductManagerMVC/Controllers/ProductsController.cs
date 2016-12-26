using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProductManagerMVC.Services;
using System.Net;
using ProductManagerMVC.Models;

namespace ProductManagerMVC.Controllers {
    public class ProductsController : Controller {

        private IProductDataService productService = ProductDataServiceConnector.GetProductDataService();

        public ActionResult Index() {
            return View(productService.GetAllProducts());
        }

        // GET: Products/Details/5
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

        // GET: Products/Create
        public ActionResult Create() {
            return View();
        }

        // POST: Products/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,Name,Category,ListPrice,Description")] Product product) {
            if (ModelState.IsValid) {
                productService.AddProduct(product);
                return RedirectToAction("Index");
            }

            return View(product);
        }

        // GET: Products/Edit/5
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
        public ActionResult Edit([Bind(Include = "Id,Name,Category,ListPrice,Description")] Product product) {
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

        protected override void Dispose(bool disposing) {
        }
    }
}