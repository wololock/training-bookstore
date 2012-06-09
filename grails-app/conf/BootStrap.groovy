import org.training.AppUser;
import org.training.AppUserAuthority;
import org.training.Authority;

class BootStrap {

	def init = { servletContext ->
		
		def adminAuthority = new Authority(authority: "ROLE_ADMIN").save(flush: true)
		def userAuthority = new Authority(authority: "ROLE_USER").save(flush: true)

		def user = new AppUser(username: "user", enabled: true, password: "user").save(flush: true)
		def admin = new AppUser(username: "admin", enabled: true, password: "admin").save(flush: true)

		AppUserAuthority.create(user, userAuthority, true)
		AppUserAuthority.create(admin, adminAuthority, true)
	}
	def destroy = {
	}
}
