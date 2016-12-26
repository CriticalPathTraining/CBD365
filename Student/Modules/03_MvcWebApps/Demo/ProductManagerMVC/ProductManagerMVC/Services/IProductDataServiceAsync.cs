using System.Linq;
using ProductManagerMVC.Models;
using System.Threading.Tasks;

namespace ProductManagerMVC.Services {

    public interface IProductDataServiceAsync {
        Task< IQueryable<Product> > GetAllProductsAsync();
        Task<Product> GetProductAsync(int id);
        Task AddProductAsync(Product product);
        Task DeleteProductAsync(int id);
        Task UpdateProductAsync(Product product);
    }
}