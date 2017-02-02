using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(tp1.Startup))]
namespace tp1
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
