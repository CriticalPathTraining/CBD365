using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace CustomerManagerWebForms.Models {
    public class CustomerServiceInMemory : ICustomerService {

        #region "samples data"
        CustomerEntity[] CustomerSampeData = {
            new CustomerEntity { Id=1, FirstName = "Bob", LastName = "Forbes", Company = "W.C. Boggs & Co.", Email = "Bob.Forbes@W.C.Boggs&Co..com", WorkPhone = "1(505)333-1111", HomePhone = "1(505)222-4444" },
            new CustomerEntity { Id=2, FirstName = "Anita", LastName = "Fletcher", Company = "VersaLife Corporation", Email = "Anita.Fletcher@VersaLifeCorporation.com", WorkPhone = "1(520)888-1111", HomePhone = "1(520)777-0000" },
            new CustomerEntity { Id=3, FirstName = "Tracy", LastName = "Christensen", Company = "Oceanic Airlines", Email = "Tracy.Christensen@OceanicAirlines.com", WorkPhone = "1(915)555-5555", HomePhone = "1(915)666-6666" },
            new CustomerEntity { Id=4, FirstName = "Reed", LastName = "Glover", Company = "Doublemeat Palace", Email = "Reed.Glover@DoublemeatPalace.com", WorkPhone = "1(512)777-7777", HomePhone = "1(512)444-0000" },
            new CustomerEntity { Id=5, FirstName = "Sandy", LastName = "Coleman", Company = "Initech", Email = "Sandy.Coleman@Initech.com", WorkPhone = "1(425)333-0000", HomePhone = "1(425)666-3333" },
            new CustomerEntity { Id=6, FirstName = "Zack", LastName = "Miller", Company = "Groovy Smoothie", Email = "Zack.Miller@GroovySmoothie.com", WorkPhone = "1(512)888-4444", HomePhone = "1(512)888-5555" },
            new CustomerEntity { Id=7, FirstName = "Rosalyn", LastName = "Osborne", Company = "Vandelay Industries", Email = "Rosalyn.Osborne@VandelayIndustries.com", WorkPhone = "1(509)555-6666", HomePhone = "1(509)111-0000" },
            new CustomerEntity { Id=8, FirstName = "Orlando", LastName = "Cooper", Company = "ARCAM Corporation", Email = "Orlando.Cooper@ARCAMCorporation.com", WorkPhone = "1(806)222-3333", HomePhone = "1(806)555-1111" },
        };
        #endregion

        private HttpRequest request = HttpContext.Current.Request;
        private HttpSessionState session = HttpContext.Current.Session;
        private List<CustomerEntity> CustomerList;

        public CustomerServiceInMemory() {

            if (session["CustomerListSessionState"] == null){
                session["CustomerListSessionState"] = new List<CustomerEntity>(CustomerSampeData);
            }

            CustomerList = (List<CustomerEntity>)session["CustomerListSessionState"];
        }

        public void Create(CustomerEntity Customer) {
            CustomerList.Add(Customer);
        }

        public void Delete(int CustomerId) {
            throw new NotImplementedException();
        }

        public IQueryable<CustomerEntity> GetCustomers() {
            return CustomerList.AsQueryable(); ;
        }

        public void Update(CustomerEntity Customer) {
            throw new NotImplementedException();
        }
    }
}