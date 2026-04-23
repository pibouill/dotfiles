/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   tree_bag.hpp                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fatkeski <fatkeski@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/07/26 20:41:34 by fatkeski          #+#    #+#             */
/*   Updated: 2025/07/26 21:14:02 by fatkeski         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#pragma once

#include "bag.hpp"

class tree_bag : virtual public bag {
protected:
	// binary search tree node structure
	struct node {
	  node *l;
	  node *r;
	  int value;
	};

	node *tree; // root node

public:
	tree_bag();
	tree_bag(const tree_bag &);
	tree_bag  &operator=(const tree_bag &);
	~tree_bag();

	node *extract_tree(); // getter
	void set_tree(node *); // sets the tree from outside into the class's tree

	virtual void insert(int);
	virtual void insert(int *array, int size);
	virtual void print() const;
	virtual void clear();

private:
	static void destroy_tree(node *);
	static void print_node(node *);
	static node *copy_node(node *); // void* -> node* cast
};
