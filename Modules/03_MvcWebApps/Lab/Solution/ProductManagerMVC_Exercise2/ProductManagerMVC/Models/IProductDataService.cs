using System.Linq;

namespace ProductManagerMVC.Models {

  public interface IProductDataService {
    IQueryable<Product> GetAllProducts();
    Product GetProduct(int id);
    void AddProduct(Product product);
    void DeleteProduct(int id);
    void UpdateProduct(Product product);
  }

}

