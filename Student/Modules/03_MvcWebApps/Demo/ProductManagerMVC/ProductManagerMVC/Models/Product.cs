using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace ProductManagerMVC.Models {

    public class Product {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; }
        public string Category { get; set; }
        [DisplayName("List Price"), DisplayFormat(DataFormatString = "{0:C2}")]
        public double ListPrice { get; set; }
        [DataType(DataType.MultilineText)]
        public string Description { get; set; }
        public string ProductImageUrl { get; set; }
    }

}