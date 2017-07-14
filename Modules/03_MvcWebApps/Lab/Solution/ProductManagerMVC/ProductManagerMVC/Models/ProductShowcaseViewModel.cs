using System.Collections.Generic;
using System.Linq;

namespace ProductManagerMVC.Models {

  public class ProductShowcaseViewModel {
    public IQueryable<Product> Products { get; set; }
    public IEnumerable<string> Categories{ get; set; }
  }

}