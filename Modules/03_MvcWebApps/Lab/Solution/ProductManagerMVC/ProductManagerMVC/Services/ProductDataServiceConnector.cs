using ProductManagerMVC.Models;

namespace ProductManagerMVC.Services {

  public class ProductDataServiceConnector {
    public static IProductDataService GetProductDataService() {
      return new InMemoryProductDataService();
    }
    public static IProductDataServiceAsync GetAsyncProductDataService() {
      return new FileBasedProductDataService();
    }
  }

}