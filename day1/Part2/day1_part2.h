/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day1_part2.h                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/03 18:34:35 by bwan-nan          #+#    #+#             */
/*   Updated: 2018/12/04 11:30:44 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */



#ifndef DAY_1_PART2_H
# define DAY_1_PART2_H

typedef struct		s_flist
{
	int				frequency;
	int				change;
	struct s_flist	*next;
}					t_flist;
#endif
