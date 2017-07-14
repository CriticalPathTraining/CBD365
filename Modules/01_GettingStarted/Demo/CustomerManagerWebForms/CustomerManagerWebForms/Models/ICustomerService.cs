
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CustomerManagerWebForms.Models {
    interface ICustomerService {
        IQueryable<CustomerEntity> GetCustomers();
        void Create(CustomerEntity Customer);
        void Update(CustomerEntity Customer);
        void Delete(int CustomerId);
    }
}