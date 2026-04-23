/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   bag.hpp                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fatkeski <fatkeski@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/07/26 19:12:00 by fatkeski          #+#    #+#             */
/*   Updated: 2025/07/26 19:25:00 by fatkeski         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#pragma once // multiple include guard -> "After this file is included once, if the same file is included a second time, ignore it."

// bag data structure is equivalent to multiset. It's a structure that holds a value and how many of it there are.
// abstract class or even interface. Everything that is a bag must be able to do the following 4 operations
class bag
{
 public:
	virtual void insert (int) = 0;
	virtual void insert (int *, int) = 0;
	virtual void print() const = 0;
	virtual void clear() = 0;
};
