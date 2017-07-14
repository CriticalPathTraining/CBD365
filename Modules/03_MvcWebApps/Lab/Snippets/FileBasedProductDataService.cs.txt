using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
using System.IO;
using Newtonsoft.Json;

using ProductManagerMVC.Models;

namespace ProductManagerMVC.Services {

    public class FileBasedProductDataService : IProductDataServiceAsync {

        private HttpRequest request = HttpContext.Current.Request;
        private string filePath = HttpContext.Current.Server.MapPath(@"~\App_Data\productList.json");

        async Task SaveProductListToFileAsync(List<Product> productList) {
            string json = JsonConvert.SerializeObject(productList);
            FileStream fs = new FileStream(filePath, FileMode.Create, FileAccess.Write);
            StreamWriter writer = new StreamWriter(fs);
            await writer.WriteAsync(json);
            writer.Flush();
            writer.Dispose();
            fs.Dispose();
        }

        async Task<List<Product>> GetProductListFromFileAsync() {
            if (!File.Exists(filePath)) {
                await SaveProductListToFileAsync(_productListSeedData);
            }
            FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read);
            StreamReader reader = new StreamReader(fs);
            string json = await reader.ReadToEndAsync();
            reader.Dispose();
            fs.Dispose();

            return JsonConvert.DeserializeObject<List<Product>>(json);
        }

        public async Task<IQueryable<Product>> GetAllProductsAsync() {
            List<Product> productsList = await GetProductListFromFileAsync();
            return productsList.AsQueryable();
        }

        public async Task<Product> GetProductAsync(int id) {
            List<Product> productList = await GetProductListFromFileAsync();
            return productList.Find(p => p.Id == id);
        }

        public async Task AddProductAsync(Product product) {
            List<Product> productList = await GetProductListFromFileAsync();
            int nextId = productList.Max(p => p.Id) + 1;
            product.Id = nextId;
            productList.Add(product);
            await SaveProductListToFileAsync(productList);
        }

        public async Task DeleteProductAsync(int id) {
            List<Product> productList = await GetProductListFromFileAsync();
            Product product = productList.FirstOrDefault(p => p.Id == id);
            productList.Remove(product);
            await SaveProductListToFileAsync(productList);
        }

        public async Task UpdateProductAsync(Product product) {
            List<Product> productList = await GetProductListFromFileAsync();
            Product targetProduct = productList.AsQueryable().FirstOrDefault(p => p.Id == product.Id);
            targetProduct.Name = product.Name;
            targetProduct.Category = product.Category;
            targetProduct.ListPrice = product.ListPrice;
            targetProduct.Description = product.Description;
            await SaveProductListToFileAsync(productList);
        }

        #region "Sample Seed Data"
        private List<Product> _productListSeedData = new List<Product>() {
            new Product{ Id=1, Name="Batman Action Figure", ListPrice=14.95, Category="Action Figures", Description="A super hero who sometimes plays the role of a dark knight.", ProductImageUrl="WP0001.jpg" },
            new Product{ Id=2, Name="Captain America Action Figure", ListPrice=12.95, Category="Action Figures", Description="A super action figure that protects freedom and the American way of life.", ProductImageUrl="WP0002.jpg" },
            new Product{ Id=3, Name="Easel with Supply Trays", ListPrice=49.95, Category="Arts and Crafts", Description="A serious easel for serious young artists.", ProductImageUrl="WP0003.jpg" },
            new Product{ Id=4, Name="Crate o' Crayons", ListPrice=14.95, Category="Arts and Crafts", Description="More crayons that you can shake a stick at.", ProductImageUrl="WP0004.jpg" },
            new Product{ Id=5, Name="Green Stomper Bully", ListPrice=24.95, Category="Remote Control", Description="A green alternative to crush and destroy the Red Stomper Bully.", ProductImageUrl="WP0005.jpg" },
            new Product{ Id=6, Name="Indy Race Car", ListPrice=19.95, Category="Remote Control", Description="The fastest remote control race car on the market today.", ProductImageUrl="WP0006.jpg" },
            new Product{ Id=7, Name="Twitter Follower Action Figure", ListPrice=1.00, Category="Action Figures", Description="An inexpensive action figure you can never have too many of.", ProductImageUrl="WP0007.jpg" },
            new Product{ Id=8, Name="Sandpiper Prop Plane", ListPrice=24.95, Category="Remote Control", Description="A simple RC prop plane for younger pilots.", ProductImageUrl="WP0008.jpg" },
            new Product{ Id=9, Name="Etch A Sketch", ListPrice=12.95, Category="Arts and Crafts", Description="A strategic planning tool for the Romney campaign.", ProductImageUrl="WP0009.jpg" },
            new Product{ Id=10, Name="Flying Squirrel", ListPrice=69.95, Category="Remote Control", Description="A stealthy remote control plane that flies on the down-low and under the radar.", ProductImageUrl="WP0010.jpg" },
            new Product{ Id=11, Name="FOX News Chopper", ListPrice=29.95, Category="Remote Control", Description="A new chopper which can generate new events on demand.", ProductImageUrl="WP0011.jpg" },
            new Product{ Id=12, Name="Godzilla Action Figure", ListPrice=19.95, Category="Action Figures", Description="The classic and adorable action figure from those old Japanese movies.", ProductImageUrl="WP0012.jpg" },
            new Product{ Id=13, Name="Perry the Platypus Action Figure", ListPrice=21.95, Category="Action Figures", Description="A platypus who plays an overly intelligent detective sleuth on TV.", ProductImageUrl="WP0013.jpg" },
            new Product{ Id=14, Name="Seal Team 6 Helicopter", ListPrice=59.95, Category="Remote Control", Description="A serious helicopter that can open up a can of whoop-ass when required.", ProductImageUrl="WP0014.jpg" },
            new Product{ Id=15, Name="Crayloa Crayon Set", ListPrice=2.49, Category="Arts and Crafts", Description="A very fun set of crayons in every color.", ProductImageUrl="WP0015.jpg" }
        };
        #endregion
    }

}