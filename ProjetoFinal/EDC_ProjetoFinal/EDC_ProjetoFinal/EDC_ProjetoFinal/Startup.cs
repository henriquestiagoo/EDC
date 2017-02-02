using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(EDC_ProjetoFinal.Startup))]
namespace EDC_ProjetoFinal
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
