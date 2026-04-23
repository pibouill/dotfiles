/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   set.hpp                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fatkeski <fatkeski@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/07/27 21:42:38 by fatkeski          #+#    #+#             */
/*   Updated: 2025/07/28 18:03:55 by fatkeski         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "searchable_bag.hpp"

// "wrapping" operation, usually means a class provides an interface by wrapping another class,
// function or data.
// WRAPPING BY REFERENCE
class set
{
	private:
		searchable_bag& bag;
	public:
		set() = delete;
		set(const set& source) = delete;
		set& operator=(const set& source) = delete;
		set(searchable_bag& s_bag);

		bool has(int) const;
		void insert (int);
		void insert (int *, int);
		void print() const;
		void clear();

		const searchable_bag& get_bag();

		~set();

};
