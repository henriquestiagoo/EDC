using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(tp3.Startup))]
namespace tp3
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
