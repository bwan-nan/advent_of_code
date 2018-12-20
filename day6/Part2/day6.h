/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day6.h                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/19 15:43:13 by bwan-nan          #+#    #+#             */
/*   Updated: 2018/12/20 14:14:32 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef DAY6_H
# define DAY6_H

typedef struct		s_point
{
	int				x;
	int				y;
	int				element_number;
	struct s_point	*next;
}					t_point;
#endif
