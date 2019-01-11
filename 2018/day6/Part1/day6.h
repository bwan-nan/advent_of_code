/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day6.h                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/01/11 13:30:06 by bwan-nan          #+#    #+#             */
/*   Updated: 2019/01/11 13:30:09 by bwan-nan         ###   ########.fr       */
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
