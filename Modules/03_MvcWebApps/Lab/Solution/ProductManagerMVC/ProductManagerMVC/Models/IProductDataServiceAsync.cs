using System.Linq;
using System.Threading.Tasks;

namespace ProductManagerMVC.Models {

  public interface IProductDataServiceAsync {
    Task<IQueryable<Product>> GetAllProductsAsync();
    Task<Product> GetProductAsync(int id);
    Task AddProductAsync(Product product);
    Task DeleteProductAsync(int id);
    Task UpdateProductAsync(Product product);
  }

}