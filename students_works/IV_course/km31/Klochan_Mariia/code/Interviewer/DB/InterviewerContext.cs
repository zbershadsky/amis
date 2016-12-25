using Interviewer.Models;
using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace Interviewer
{
    class InterviewerContext : DbContext
    {
        public InterviewerContext()
            : base("Oracle")
        {
            
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            var schema = ConfigurationManager.AppSettings["schema"];
            modelBuilder.HasDefaultSchema(schema);
            base.OnModelCreating(modelBuilder);
        }

        public DbSet<Interview> Interviews { get; set; }
        public DbSet<InterviewLine> InterviewLines { get; set; }
        public DbSet<User> Users { get; set; }
    }
}
