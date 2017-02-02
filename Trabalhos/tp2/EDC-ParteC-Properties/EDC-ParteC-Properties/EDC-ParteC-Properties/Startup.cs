using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(EDC_ParteC_Properties.Startup))]
namespace EDC_ParteC_Properties
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
