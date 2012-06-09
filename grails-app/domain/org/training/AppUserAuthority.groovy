package org.training

import org.apache.commons.lang.builder.HashCodeBuilder

class AppUserAuthority implements Serializable {

	AppUser appUser
	Authority authority

	boolean equals(other) {
		if (!(other instanceof AppUserAuthority)) {
			return false
		}

		other.appUser?.id == appUser?.id &&
			other.authority?.id == authority?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (appUser) builder.append(appUser.id)
		if (authority) builder.append(authority.id)
		builder.toHashCode()
	}

	static AppUserAuthority get(long appUserId, long authorityId) {
		find 'from AppUserAuthority where appUser.id=:appUserId and authority.id=:authorityId',
			[appUserId: appUserId, authorityId: authorityId]
	}

	static AppUserAuthority create(AppUser appUser, Authority authority, boolean flush = false) {
		new AppUserAuthority(appUser: appUser, authority: authority).save(flush: flush, insert: true)
	}

	static boolean remove(AppUser appUser, Authority authority, boolean flush = false) {
		AppUserAuthority instance = AppUserAuthority.findByAppUserAndAuthority(appUser, authority)
		if (!instance) {
			return false
		}

		instance.delete(flush: flush)
		true
	}

	static void removeAll(AppUser appUser) {
		executeUpdate 'DELETE FROM AppUserAuthority WHERE appUser=:appUser', [appUser: appUser]
	}

	static void removeAll(Authority authority) {
		executeUpdate 'DELETE FROM AppUserAuthority WHERE authority=:authority', [authority: authority]
	}

	static mapping = {
		id composite: ['authority', 'appUser']
		version false
	}
}
